def call(){
    sh 'ansible -playbook -i inventory main.yaml'
}