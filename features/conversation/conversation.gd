## Screen to show the collection of a cat.
class_name Conversation
extends Control


signal closed

var resource: DialogueResource

##
@onready var background: ColorRect = $Background
##
@onready var phone_call_message: Label = $Background/PhoneCallMessage
##
@onready var boss_text: Label = $Tagline/BossText
##
@onready var player_text: Label = $PlayerText
##
@onready var phone = $SubViewportContainer/SubViewport/Phone
##
@onready var phone_start_y = -.07
##
@onready var clicker: Button = $Clicker
##
@onready var boss_box = $BossBox
##
@onready var ghost_box = $GhostBox


func _ready():
	hide()


func play(dialogue_path: String, is_haunting = false) -> void:
	boss_box.visible = not is_haunting
	ghost_box.visible = is_haunting
	background.visible = not is_haunting

	clicker.disabled = true
	boss_text.text = ""
	player_text.text = ""
	phone.global_position.y = phone_start_y - .13

	modulate.a = 0.0
	show()

	phone_call_message.hide()

	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 2.0)
	tween.play()
	await tween.finished

	if not is_haunting:
		phone_call_message.show()

		tween = create_tween()
		var prop = tween.tween_property(phone, "global_position:y", phone_start_y, 1.0)
		prop.set_trans(Tween.TRANS_ELASTIC)
		tween.play()
		await tween.finished

		phone_call_message.hide()

	resource = load(dialogue_path)
	next_line("start")


func stop():
	var tween: Tween = create_tween()
	var prop = tween.tween_property(phone, "global_position:y", phone_start_y - .13, 1.0)
	prop.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "modulate:a", 0.0, .5)
	tween.play()
	await tween.finished

	hide()
	closed.emit()


func next_line(id: String):
	var line = await DialogueManager.get_next_dialogue_line(resource, id)

	if not line:
		stop()
		return

	await get_tree().create_timer(.25).timeout
	clicker.disabled = false

	# This is the player (main screen).
	if line.character == "":
		player_text.text = line.text
		boss_text.text = ""
	# This is not the player (side screens).
	else:
		player_text.text = ""
		boss_text.text = line.text

	await clicker.pressed
	clicker.disabled = true

	player_text.text = ""
	boss_text.text = ""

	if line.next_id:
		next_line(line.next_id)
	else:
		stop()
