import requests
import sys
import time

API_KEY = "9aa309e08dcc49c7b9d8703439f9e571"

def upload_audio(file_path):
    headers = {'authorization': API_KEY}
    with open(file_path, 'rb') as f:
        response = requests.post('https://api.assemblyai.com/v2/upload', headers=headers, files={'file': f})
    return response.json()['upload_url']

def transcribe_audio(upload_url):
    endpoint = "https://api.assemblyai.com/v2/transcript"
    json_data = {"audio_url": upload_url, "audio_format": "pcm"}
    headers = {"authorization": API_KEY, "content-type": "application/json"}
    response = requests.post(endpoint, json=json_data, headers=headers)
    return response.json()

def get_transcription(transcription_id):
    endpoint = f"https://api.assemblyai.com/v2/transcript/{transcription_id}"
    headers = {"authorization": API_KEY}
    
    while True:
        response = requests.get(endpoint, headers=headers)
        status = response.json()['status']
        
        if status == 'completed':
            return response.json()['text']
        elif status == 'failed':
            raise Exception('Transcription failed')
        
        time.sleep(5)

def transcribe_pcm_to_text(file_path):
    upload_url = upload_audio(file_path)
    transcription_response = transcribe_audio(upload_url)
    transcription_id = transcription_response['id']
    transcription_text = get_transcription(transcription_id)
    print(transcription_text)

if __name__ == "__main__":
    pcm_file = sys.argv[1]  # Accept PCM file from command-line argument
    transcribe_pcm_to_text(pcm_file)
