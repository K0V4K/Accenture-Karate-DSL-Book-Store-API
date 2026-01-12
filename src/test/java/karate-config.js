function fn() {
  var config = {
    baseUrl: 'https://bookstore.demoqa.com',
    // Nome dinâmico para evitar erro de usuário já existente
    authUserName: 'ValterAccenture_' + java.lang.System.currentTimeMillis(),
    authPassword: 'SenhaForte@123!'
  };

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);

  return config;
}