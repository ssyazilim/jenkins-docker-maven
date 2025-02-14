# Depo ayaga kalktiktan sonra root olarak giris yapamadigini fark ettin [sudo docker exec -it git-server bash] komutunu calistirarak Container icerisinde session olusturdun.
# Daha sonra [gitlab-rails console] komutunu calistirdin ve rails console icerisinde bir session actin
# Acilan session icerisinde [user = User.find_by_username 'root'] komutunu calistirdin biraz bekle ardindan [user.password = '<Your password>'] ve hemen ardindan [user.password_confirmation = '<Your password>'] dedin
# En son olarak da [user.save!] dedin ve islemini tamamladin. Tebrikler artik root olarak oturum acabilirsin.
