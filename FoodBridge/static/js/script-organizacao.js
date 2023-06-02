document.getElementById('cadastro-organizacao').addEventListener('submit', function(event) {
    event.preventDefault();
  
    var organizacao = {
      nome: document.getElementById('nome').value,
      endereco: document.getElementById('endereco').value,
      telefone: document.getElementById('telefone').value
    };
  
    fetch('http://localhost:5000/cadastro-organizacao', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(organizacao)
    })
    .then(response => response.json())
    .then(data => console.log(data))
    .catch((error) => {
      console.error('Error:', error);
    });
  });
  