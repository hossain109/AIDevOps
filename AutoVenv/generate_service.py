import ollama

PROMPT = """
    Generate an ideal kubernetes service file{language} with best practice. Just share servicefile without any explanation
    between two lines to make coping the file easy.
    Include:
    - Base image
    - Installing dependancies
    - Adding source code
    - Running the application
    - Expose port
"""

def generate_servicefile(language):
    response = ollama.chat(model='llama3.2:1b',messages=[{'role':'user', 'content':PROMPT.format(language=language)}])
    return response['message']['content'] 


if __name__ == '__main__':
    language = input('Enter the programming language: ')
    servicefile = generate_servicefile(language)
    print("\n Generate servicefile:\n")
    print(servicefile)


   #result
   # apiVersion: v1
# kind: Service
# metadata:
#   name: my-kubernetes-service
# spec:
#   selector:
#     app: my-app
#   ports:
#   - name: http
#     port: 80
#     targetPort: 8080
#   type: LoadBalancer 