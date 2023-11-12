## Makes the process of loading a .csv file slightly easier.
##
## Line-by-line processes each line of a .csv file into an array.
class_name CsvLoader
extends Object


## Loads and returns the given .csv file into an Array of Dictionary instances.
static func open(csv_path: String, indexed_by_rows = false, ignore_first_row = false) -> Array[Dictionary]:
	var file := FileAccess.open(csv_path, FileAccess.READ)
	var lines: Array[Dictionary] = []

	# If we should ignore the first row, just go ahead and do that.
	if ignore_first_row:
		file.get_csv_line()

	if indexed_by_rows:
		var rows = []
		while not file.eof_reached():
			var row = Array(file.get_csv_line())

			# Skip blank lines.
			if row[0]:
				rows.append(row)

		var headers: Array[String] = []
		for row in rows:
			headers.append(row.pop_front())

		var columns = []
		for i in range(0, rows[0].size()):
			columns.append(rows.map(func (row):
				return row[i]
			))

		for column in columns:
			lines.append(_process_row(headers, column))

	else:
		# The first line will always be headers.
		var headers := file.get_csv_line()

		# While more data is available, parse lines.
		while file.get_position() < file.get_length():
			var body = file.get_csv_line()
			lines.append(_process_row(headers, body))

	file.close()
	return lines


## Stitches together equally-sized headers and body Arrays into a Dictionary.
static func _process_row(headers: Array, body: Array) -> Dictionary:
	assert(headers.size() == body.size(), "Mismatch in headers and body size")

	var data: Dictionary = {}

	for index in headers.size():
		var header = headers[index]

		# Skip blank lines.
		if not header:
			continue

		data[header] = body[index]

	return data
