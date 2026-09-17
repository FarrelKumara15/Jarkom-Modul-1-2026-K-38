#!/bin/sh

# 1. Update repositori dan install OpenSSH
apk update
apk add openssh

# 2. Generate host keys untuk server
ssh-keygen -A

# 3. Membuat user mika_admin secara non-interaktif (tanpa prompt password)
adduser -D mika_admin

# 4. Membuat direktori .ssh untuk user mika_admin dan mengatur hak aksesnya
mkdir -p /home/mika_admin/.ssh
chmod 700 /home/mika_admin/.ssh
chown mika_admin:mika_admin /home/mika_admin/.ssh

# 5. Memasukkan Public Key dari client ke authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnZpr9jsGha0E3Q3VTTXAdqLJfeNHb2y2INkYmWtfY9rPBLqbht5tFxG0W8ajlEf1349MaORji+fjPKIMwm4bxx4/k0fJZpnxNXMRNUMHx0uVYXoslZXbkYtHXkb0B/aAJcKRXUsBNlq6aLqncVSvp/Z/UHB9wKwtIziTQgz/TmR7Ak3ZESNEOx108Fd/XG2/rAFvAmJPDypy6EUW7uPxxjS3ca1/MhJ5fxzKGeC7jMm76RUxhfrGtzq/kOlG3BXJpEoc8sKO6npFptxr9WbkYWvEJvvX0TD2Qu+NddLowm1osEBu7B3Yid9AS/uKQouL//dyVSlMYgjlbeDrpOktp0pmKj3mgnDmpG/0eOQcnkl1qqeY4CRPFwH5KAtewSFMe3oysXAmbEyAO9flV00fI0JDk7GyNV086nHP4WkoO9NrVEgHBSQHQpxlqPnnaK4u+8NSw3ohL2ctYmO3Liv1gFvw4XrOctkpHlhekuSfTPBBekxIELqSW8eickgEunLHt6lJ4JPULqlwldfrMmqE3eC4IKTzCb+ALpIR0oneKUuDGLns0nVnqSB0TZINWZrYFFG3su0rdMUQmgmiCGZT2G9j5eoK7cWbJ+xD3QnCUD7cVuqtsXJ2GWMJcTt1UQh2SbqQD16Yx2XxO/ycz0pjfKxFC/26ulTg1T6nfPLQHmw== mika_admin" >> /home/mika_admin/.ssh/authorized_keys

# 6. Mengatur hak akses file authorized_keys
chmod 600 /home/mika_admin/.ssh/authorized_keys
chown mika_admin:mika_admin /home/mika_admin/.ssh/authorized_keys

# 7. Menjalankan SSH Daemon di latar belakang
/usr/sbin/sshd