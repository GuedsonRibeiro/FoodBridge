document.getElementById('cadastro-doador').addEventListener('submit', function(event) {
    event.preventDefault();
  
    var doador = {
      nome: document.getElementById('nome').value,
      endereco: document.getElementById('endereco').value,
      telefone: document.getElementById('telefone').value
    };
  
    fetch('http://localhost:5000/cadastro-doador', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(doador)
    })
    .then(response => response.json())
    .then(data => console.log(data))
    .catch((error) => {
      console.error('Error:', error);
    });
  });
  