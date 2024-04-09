const express = require('express');
const cors = require('cors');
const mysql = require("mysql2/promise");

// create and config server
const server = express();
server.use(cors());
server.use(express.json());

// Nos conectamos a la base de datos
async function getDBConnection(){
  const connection = await mysql.createConnection({
      //Siempre tenemos que poner estos datos, y consultamos cómo rellenarlos en MySQL Workbench 
      host: "127.0.0.1", 
      user: "root",
      password: "SheCodes0",
      database: "Netflix",
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

//Creamos el endpoint 
server.get("/movies", async (req, res) => {

  try {
      const connection = await getDBConnection();

  const sql = "SELECT * FROM movies";

  // Hacemos la consulta
  const [moviesResult] = await connection.query(sql);
  console.log(moviesResult);

  //Cerrar la conexión con la base de datos
  connection.end();

  //Devolvemos la respuesta, en este caso con un objeto que tenga el código de que todo ha ido bien, el status y un mensaje
  res.status(200).json({
      status: "success", 
      message: moviesResult, 
  });
  } catch (error) {
      res.status(500).json({
          status: "error",
          message: "Ha habido un error interno. Contacte suporte", 
      });
  }
  
});
