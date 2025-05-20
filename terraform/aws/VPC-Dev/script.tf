# resource "null_resource" "copiar_archivo" {
#   depends_on = [aws_instance.ejemplo]

#   provisioner "file" {
#     source      = "mi_archivo.txt"                  # Archivo local
#     destination = "/home/ec2-user/mi_archivo.txt"   # Ruta destino en EC2

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file("~/.ssh/mi_clave_ssh.pem") # Cambia por tu clave privada
#       host        = aws_instance.ll-  # IP pública de la instancia
#     }
#   }
# }