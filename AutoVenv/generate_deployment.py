import ollama

PROMPT = """
    Generate an ideal kubernetes deployment file{language} with best practice. Just share the deploymentfile without any explanation
    between two lines to make coping the file easy.
    Include:
    - Base image
    - Installing dependancies
    - Adding source code
    - Running the application
    - Expose port
"""

def generate_deploymentfile(language):
    response = ollama.chat(model='llama3.2:1b',messages=[{'role':'user', 'content':PROMPT.format(language=language)}])
    return response['message']['content'] 


if __name__ == '__main__':
    language = input('Enter the programming language: ')
    deploymentfile = generate_deploymentfile(language)
    print("\n Generate deploymentfile:\n")
    print(deploymentfile)



#   resultat
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: your-deployment
# spec:
#   replicas: 3
#   selector:
#     matchLabels:
#       app: my-app
#   template:
#     metadata:
#       labels:
#         app: my-app
#     spec:
#       containers:
#       - name: your-container
#         image: gcr.io/your-project-id/your-image-name
#         ports:
#         - containerPort: 80
#   service:
#     type: LoadBalancer