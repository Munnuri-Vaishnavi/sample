<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Jenkins Automation Project demo second time</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #222;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .container {
            padding: 40px;
            text-align: center;
        }

        .card {
            background: white;
            padding: 30px;
            margin: 20px auto;
            width: 60%;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        h1 {
            margin: 0;
        }

        .btn {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>

<header>
    <h1>🚀 Automating Projects Using Jenkins</h1>
</header>

<div class="container">

    <div class="card">
        <h2>Welcome Vaishnavi 👋</h2>
        <p>This project demonstrates Continuous Integration using Jenkins and Maven.</p>
        <p>Every code change is automatically built and deployed.</p>
    </div>

    <div class="card">
        <h2>Technologies Used</h2>
        <p>✔ Jenkins</p>
        <p>✔ Maven</p>
        <p>✔ GitHub</p>
        <p>✔ Apache Tomcat</p>
    </div>

    <div class="card">
        <h2>Automation Flow</h2>
        <p>Code → GitHub → Jenkins Build → WAR → Tomcat → Browser</p>
        <br>
        <a class="btn" href="#">Build Successful 🎉</a>
    </div>

</div>

</body>
</html>
