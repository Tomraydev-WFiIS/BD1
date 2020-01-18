import psycopg2
import os

from flask import send_from_directory, render_template
from project import app


@app.route("/")
def hello_world():
    # test
    conn = psycopg2.connect(dbname="flight_radar_db", user="tomray", host="db", password="tomray")
    cur = conn.cursor()
    cur.execute("SELECT * FROM test;")
    items = cur.fetchall()
    conn.close()
    print(items)
    # /test
    return render_template("index.html")


@app.route('/favicon.ico') 
def favicon(): 
    return send_from_directory(os.path.join(app.root_path, 'static'), 'favicon.ico', mimetype='image/vnd.microsoft.icon')