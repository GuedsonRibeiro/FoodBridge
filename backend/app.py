import json
import mysql.connector
from flask import Flask, request, jsonify, render_template
from flask_cors import CORS

app = Flask(__name__, static_folder='frontend/public', static_url_path='/static')

cors = CORS(app, resources={r"/*": {"origins": "*"}})

db_config = {
    'host': 'YOUR_HOST',
    'user': 'YOUR_USER',
    'password': 'YOUR_PASSWORD',
    'database': 'YOUR_DATABASE_NAME'
}

def insert_doador(doador):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    query = """
        INSERT INTO DOADORES
        (Nome, Endereco, Telefone)
        VALUES (%s, %s, %s)
    """
    values = (
        doador['nome'],
        doador['endereco'],
        doador['telefone'],
    )
    cursor.execute(query, values)
    conn.commit()

    cursor.close()
    conn.close()

def insert_organizacao(organizacao):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    query = """
        INSERT INTO ORGANIZACOES
        (Nome, Endereco, Telefone)
        VALUES (%s, %s, %s)
    """
    values = (
        organizacao['nome'],
        organizacao['endereco'],
        organizacao['telefone'],
    )
    cursor.execute(query, values)
    conn.commit()

    cursor.close()
    conn.close()

def insert_doacao(doacao):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    query = """
        INSERT INTO DOACOES
        (ID_Doador, ID_Organizacao, Tipo_de_Alimento, Quantidade, Data)
        VALUES (%s, %s, %s, %s, %s)
    """
    values = (
        doacao['id_doador'],
        doacao['id_organizacao'],
        doacao['tipo_de_alimento'],
        doacao['quantidade'],
        doacao['data'],
    )
    cursor.execute(query, values)
    conn.commit()

    cursor.close()
    conn.close()

@app.route('/')
def home():
    return app.send_static_file('index.html')

@app.route('/cadastro-doador')
def cadastro_doador():
    return app.send_static_file('cadastro-doador.html')

@app.route('/cadastro-organizacao')
def cadastro_organizacao():
    return app.send_static_file('cadastro-organizacao.html')

@app.route('/doacoes')
def doacoes():
    return app.send_static_file('doacoes.html')

@app.route('/api/cadastro-doador', methods=['POST'])
def api_cadastro_doador():
    doador = request.get_json()
    insert_doador(doador)
    return jsonify({'mensagem': 'Doador cadastrado com sucesso!'})

@app.route('/api/cadastro-organizacao', methods=['POST'])
def api_cadastro_organizacao():
    organizacao = request.get_json()
    insert_organizacao(organizacao)
    return jsonify({'mensagem': 'Organização cadastrada com sucesso!'})

@app.route('/api/doacoes', methods=['POST'])
def api_doacoes():
    doacao = request.get_json()
    insert_doacao(doacao)
    return jsonify({'mensagem': 'Doação registrada com sucesso!'})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)
