import ollama

PROMPT = """
    Generate an ideal dockerfile{language} with best practice. Just share the dockerfile without any explanation
    between two lines to make coping the file easy.
    Include:
    - Base image
    - Installing dependancies
    - Setting working directory
    - Adding source code
    - Running the application
    - Multistage destroyless docker image
    - Expose port
"""

def generate_dockerfile(language):
    response = ollama.chat(model='llama3.2:1b',messages=[{'role':'user', 'content':PROMPT.format(language=language)}])
    return response['message']['content'] 


if __name__ == '__main__':
    language = input('Enter the programming language: ')
    dockerfile = generate_dockerfile(language)
    print("\n Generate dockerfile:\n")
    print(dockerfile)