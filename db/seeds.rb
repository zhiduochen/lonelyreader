# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Initialize Admin User
if User.find_by(email: "admin@test.com").nil?
  u = User.new
  u.email = "1@1.com"           # 可以改成自己的 email

  u.password = "123456"                # 最少要六码

  u.password_confirmation = "123456"   # 最少要六码

  u.is_admin = true
  u.save
  puts "Admin 已经建立好了，帐号为#{u.email}, 密码为#{u.password}"
 else
   puts "Admin 已经建立过了，脚本跳过该步骤。"
 end

 # Initialize Product

  Product.create!(title: "西方文明简史",
    description: "欧洲自古希腊城邦至二战结束全脉络",
    price: 900,
    quantity: 100,
    image: open("https://ws3.sinaimg.cn/large/006tKfTcly1fg4o01e53pj30dc07imy2.jpg")
    )

  Product.create!(title: "西方哲学史",
    description: "概览二十位哲学家的观点",
    price: 600,
    quantity: 100,
    image: open("https://ws4.sinaimg.cn/large/006tKfTcly1fg4o197obij30dc07iweo.jpg")
    )

  Product.create!(title: "西方艺术简史",
    description: "自希腊时期至二十世纪早期的西方视觉艺术",
    price: 900,
    quantity: 100,
    image: open("https://ws3.sinaimg.cn/large/006tKfTcly1fg4o1p0c72j30dc07i3z3.jpg")
    )

  Product.create!(title: "政治哲学导论",
    description: "赏析深刻的政治思想，重塑思辨体系",
    price: 600,
    quantity: 100,
    image: open("https://ws3.sinaimg.cn/large/006tKfTcly1fg4o25k74kj30dc07i3yt.jpg")
    )

  Product.create!(title: "社会学概论",
    description: "概览社会学领域研究话题",
    price: 600,
    quantity: 100,
    image: open("https://ws3.sinaimg.cn/large/006tKfTcly1fg4o2lo600j30dc07iaax.jpg")
    )

  Product.create!(title: "社会学心理学",
    description: "洞悉人心的秘密，了解自己的思绪",
    price: 600,
    quantity: 100,
    image: open("https://ws1.sinaimg.cn/large/006tKfTcly1fg4o2z1n7tj30dc07iglv.jpg")
    )
