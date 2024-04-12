const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

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

// GENERAR TOKEN

function generateToken(tokenInfo) {
  const token = jwt.sign(tokenInfo, 'secret_key_lo_que_quiera', {
    // guardar la clave secreta en una varible de entorno, en mi .env
    expiresIn: '1h',
  });
  return token;
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
  const sqlQuery = 'SELECT * FROM movies WHERE idMovies = ?';
  const [movieFound] = await connection.query(sqlQuery, [req.params.movieId]);
  console.log(movieFound);
  connection.end();
  res.render('movie', { movie: movieFound[0] });
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

server.post('/signup', async (req, res) => {
  const { email, password } = req.body;

  const connection = await getDBConnection();
  const emailQuery = 'SELECT * FROM users WHERE email = ? ';
  const [emailResult] = await connection.query(emailQuery, [email]);

  if (emailResult.length === 0) {
    const passwordHashed = await bcrypt.hash(password, 10);
    const newUserQuery = 'INSERT INTO users(passwordUsers, email)VALUES(?, ?)';

    const [newUserResult] = await connection.query(newUserQuery, [
      passwordHashed,
      email,
    ]);

    res.status(201).json({
      success: true,
      data: newUserResult,
    });
  } else {
    res.status(400).json({
      success: false,
      message: 'Email already registered',
    });
  }
});

server.post('/login', async (req, res) => {
  const { email, password } = req.body;
  const connection = await getDBConnection();
  const emailQuery = 'SELECT * FROM users WHERE email = ? ';
  const [userResult] = await connection.query(emailQuery, [email]);

  const userIsRegister = userResult.length > 0;

  if (userIsRegister) {
    const isSamePassword = await bcrypt.compare(
      password,
      userResult[0].passwordUsers
    );

    if (isSamePassword) {
      const infoToken = {
        id: userResult[0].idUsers,
        email: userResult[0].email,
      };
      const token = generateToken(infoToken);

      res.status(200).json({
        status: true,
        token: token,
      });
    } else {
      res.status(400).json({
        status: false,
        message: 'Invalid password',
      });
    }
  } else {
    res.status(400).json({
      success: false,
      message: 'Not user found',
    });
  }
});

//Servidor de estáticos
const pathStatic = './src/public-react';
server.use(express.static(pathStatic));
