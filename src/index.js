const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');

// create and config server
const server = express();
server.use(cors());
server.use(express.json());
server.set('view engine', 'ejs');

// Nos conectamos a la base de datos
async function getDBConnection() {
  const connection = await mysql.createConnection({
    //Siempre tenemos que poner estos datos, y consultamos cómo rellenarlos en MySQL Workbench
    host: 'sql.freedb.tech',
    user: 'freedb_admin_team4',
    password: 'W4Vtbet*dv9MrkK',
    database: 'freedb_netflix',
  });

  //Nos conectamos
  connection.connect();
  return connection;
}

//Establecer el puerto que queremos usar
// init express aplication
const serverPort = 6001;
server.listen(serverPort, () => {
  console.log(`Server listening at http://localhost:${serverPort}`);
});


//Endpoint (motor de plantillas)
server.get('/movie/:movieId', async (req, res) => {
  const connection = await getDBConnection();
  console.log(req.params.movieId);
  const sqlQuery = "SELECT * FROM movies WHERE idMovies = ?"; 
  const [movieFound] = await connection.query(sqlQuery, [req.params.movieId]);
  console.log(movieFound);
  connection.end();
  res.render("movie", {movie: movieFound[0]});

});

//Creamos el endpoint
server.get('/movies', async (req, res) => {
  try {
    const connection = await getDBConnection();

    const sql = 'SELECT * FROM movies';

    // Hacemos la consulta
    const [moviesResult] = await connection.query(sql);
    console.log(moviesResult);

    //Cerrar la conexión con la base de datos
    connection.end();

    //Devolvemos la respuesta, en este caso con un objeto que tenga el código de que todo ha ido bien, el status y un mensaje
    res.status(200).json({
      status: 'success',
      message: moviesResult,
    });
  } catch (error) {
    res.status(500).json({
      status: 'error',
      message: 'Ha habido un error interno. Contacte suporte',
    });
  }
});

//Servidor de estáticos 
const pathStatic = "./src/public-react";
server.use(express.static(pathStatic));
