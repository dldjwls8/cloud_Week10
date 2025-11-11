from flask import Flask, render_template, jsonify
import json
import os

app = Flask(__name__)

# JSON 데이터 파일 경로
DATA_FILE = os.path.join(os.path.dirname(__file__), 'data', 'project_data.json')

def load_data():
    """JSON 파일에서 데이터 로드"""
    with open(DATA_FILE, 'r', encoding='utf-8') as f:
        return json.load(f)

# 홈페이지 (메인)
@app.route('/')
@app.route('/main')
def main():
    data = load_data()
    return render_template('main.html', project=data['project'])

# 작품 주제
@app.route('/subject')
def subject():
    data = load_data()
    return render_template('subject.html', subject=data['subject'])

# 실용적 근거
@app.route('/rationale')
def rationale():
    data = load_data()
    return render_template('rationale.html', rationale=data['rationale'])

# 핵심 기능
@app.route('/features')
def features():
    data = load_data()
    return render_template('features.html', features=data['features'])

# 구현 환경
@app.route('/environment')
def environment():
    data = load_data()
    return render_template('environment.html', environment=data['environment'])

# 팀 구성 및 역할
@app.route('/team')
def team():
    data = load_data()
    return render_template('team.html', team=data['team'])

# ========== API 엔드포인트 ==========

@app.route('/api/subject')
def api_subject():
    """작품 주제 API"""
    data = load_data()
    return jsonify(data['subject'])

@app.route('/api/rationale')
def api_rationale():
    """실용적 근거 API"""
    data = load_data()
    return jsonify(data['rationale'])

@app.route('/api/features')
def api_features():
    """핵심 기능 API"""
    data = load_data()
    return jsonify(data['features'])

@app.route('/api/environment')
def api_environment():
    """구현 환경 API"""
    data = load_data()
    return jsonify(data['environment'])

@app.route('/api/team')
def api_team():
    """팀 구성 및 역할 API"""
    data = load_data()
    return jsonify(data['team'])

@app.route('/api/all')
def api_all():
    """전체 데이터 API"""
    data = load_data()
    return jsonify(data)

# 에러 핸들러
@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
