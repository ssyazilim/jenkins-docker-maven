# Jenkins ilk baslatildiginda senden guvenlik icin bir key isteyecek [docker logs -f jenkins] komutu ile loglari ac ve oradaki keyi al jenkins arayuzune yapistir. Diger islemleri tamamla

# Bu dizin icerisine bir adet PEM ile crypted edilmis bir key olustur [ssh-keygen -t rsa -b 4096 -f /remote-key] komutunu kullanma
# Kullanacagin komut [ssh-keygen -f remote-key -m PEM]
# Daha sonra bir dizin geri git ve [docker compose up -d --build] komutu ile docker-compose.yml dosyani tetikle
# Container iki adet olusacak bir tanesi jenkins bir tanesi remote_host
# Jenkins isimli container icerisinde session ac [docker exec -it jenkins bash]
# Jenkins container icerisinde session actiktan sonra olusturmus oldugun container in container yapisindaki remote-host container servisine bir ssh at [ssh remote_user@remote_host]
# Simdi bu remote-host container servisinin calistigindan emin olduktan sonra [exit] ile jenkins container servisine geri git ve [ping remote_host] komutunu calistir. Hata alacaksin!
# [docker exec -u root -ti jenkins bash] komutu ile sudo yetkisi alarak jenkins container icerisine session ac
# Session olusturduktan sonra ilk olarak [apt update] daha sonra [apt install iputils-ping] komutlarini calistir ve tekrar [ping remote_host] calistir
# Daha sonra ubuntu dizinine git ve [docker cp remote-key jenkins:/tmp/remote-key] komutu ile olusturmus oldugun key dosyasini jenkins container icerisinde /tmp dizinine tasi
# [docker exec -it jenkins bash] yaparak jenkins container icerisine gir ve /tmp dizinine giderek [ssh -i remote_key remote_user@remote_host] komutu ile login olmaya calis
# Login islemini gerceklestirdigin sirada seni kabul etmeyecek ve senden tekrar sifre isteyecek bu sorunu cozmek icin su adimlari takip et
# Tekrar jenkins container icerisine sudo yetkisi ile baglan [docker exec -it -u root jenkins /bin/bash]
# Baglanti kurulduktan sonra /tmp dizinine git ve [chown jenkins:jenkins remote-key] komutu ile izinleri yeniden duzenle
# Bu islemleri gerceklestirdikten sonra jenkins container icerisinden  [ssh -i remote-key remote_user@remote_host] komutu ile sifre girmeden session olusturabilirsin

# Jenkins arayuzune giris yap [192.168.1.16:8080] uzerinden local olarak kurmus oldugun jenkins arayuzune giris yapabilirsin.
# MANAGE JENKINS sekmesine tikla daha sonra PLUGINS secenegini sec ve AVAILABLE PLUGINS sekmesine tika acilan yerde [ssh] diye arat ve bu plugini yukle ardindan jenkinsi yeniden baslat
# MANAGE JENKINS sekmesine git ve CREDENTIALS icerisine gir SYSTEM -> GLOBAL CREDENTIALS -> ADD CREDENTIALS
# Kind: SSH Username with private key | Scope: Global (Jenkins, nodes, items, all child items, etc) | Username: remote_user | Private Key: Enter directly (Copy private key here)
# MANAGE JENKINS ve ardindan SYSTEM icerisine giris yap ve SSH remote hosts kismina gel Add butonuna tikla
# Hostname: remote_host | Port: 22 | Credentials: remote_user
# Daha sonra check connection butonuna tikla ve baglantini test et ardindan kayit et

# NEW ITEM sekmesine tikla ve bir job baslat remote-task isminde bir freestyle project olabilir
# Build steps altindan Add build step ve daha sonra Execute shell script on remote host using ssh ve su komutu calistir [echo "Hello David. Current date is $(date)" > /tmp/remote-file]
# Daha sonra [docker exec -ti remote-host bash] komutuna gir ve [cat /tmp/remote-file] komutunu calistirip bash calistirildigindan emin ol
