resource "aws_instance" "nginx" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.nginx.id
  ]

  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash

              dnf update -y
              dnf install -y nginx

              systemctl enable nginx
              systemctl start nginx

              cat > /usr/share/nginx/html/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>DevOps Learning</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0f172a;
            color: white;
        }

        .container {
            max-width: 1200px;
            margin: auto;
            padding: 60px 20px;
            text-align: center;
        }

        h1 {
            font-size: 70px;
            margin-bottom: 20px;
        }

        p {
            font-size: 24px;
            color: #cbd5e1;
        }

        .card-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 50px;
        }

        .card {
            background: #1e293b;
            padding: 30px;
            border-radius: 15px;
            width: 250px;
        }

        .card h2 {
            color: #38bdf8;
        }

        .button {
            display: inline-block;
            margin-top: 30px;
            padding: 15px 30px;
            background: #38bdf8;
            color: #0f172a;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
        }
    </style>
</head>

<body>

    <div class="container">

        <h1>DevOps 🚀</h1>

        <p>
            Learn DevOps, Cloud, Automation and Infrastructure as Code
        </p>

        <div class="card-container">

            <div class="card">
                <h2>Linux</h2>
                <p>Learn Linux administration and commands.</p>
            </div>

            <div class="card">
                <h2>Docker</h2>
                <p>Build and run applications using containers.</p>
            </div>

            <div class="card">
                <h2>AWS</h2>
                <p>Deploy scalable applications on AWS Cloud.</p>
            </div>

            <div class="card">
                <h2>Terraform</h2>
                <p>Manage infrastructure using Infrastructure as Code.</p>
            </div>

            <div class="card">
                <h2>GitHub</h2>
                <p>Manage source code and automate CI/CD pipelines.</p>
            </div>

            <div class="card">
                <h2>Kubernetes</h2>
                <p>Orchestrate and manage containers at scale.</p>
            </div>

        </div>

        <a href="#" class="button">
            Start Learning DevOps
        </a>

    </div>

</body>
</html>
HTML
              EOF

  tags = {
    Name = "terraform-nginx-server"
  }
}