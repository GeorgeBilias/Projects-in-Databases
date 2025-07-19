import csv
import ast

r = open("keywords.csv", 'r',encoding="utf8")
reader = csv.reader(r)

w = open("keyword.csv", 'w',encoding="utf8")
w2 = open("movie_keywords.csv", 'w',encoding="utf8")

writer = csv.writer(w,quotechar= '"',quoting=csv.QUOTE_NONNUMERIC,lineterminator='\n')
writer2 = csv.writer(w2,lineterminator='\n')

w.write("id,name\n")
w2.write("movie_id,keyword_id\n")

header = next(reader)

for header in reader:
  data = ast.literal_eval(header[1])
  for exact in data:
    row = [exact['id'],exact['name']]
    row2 = [header[0],exact['id']]
    writer.writerow(row)
    writer2.writerow(row2)
w.close()
w2.close()
r.close()