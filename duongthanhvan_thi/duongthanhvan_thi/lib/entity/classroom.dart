class Classroom {
  late String semeter;
  late String subject;
  late String id;
  late int totalStudent;
  late String bgUrl;
  Classroom(this.id, this.semeter, this.subject, this.totalStudent, 
   {this.bgUrl = ""}
   );
  
}
String url1= "https://bazaarvietnam.vn/wp-content/uploads/2019/07/2019227-lang-Tu-Duc-05.jpg";
String url2= "https://upload.wikimedia.org/wikipedia/commons/c/cc/Ngomon2.jpg";
String url3= "https://static.doanhnhan.vn/images/upload/09202024/cua_hang_uniqlo_aeon_mall_hue_du_kien_khai_truong_trong_nam_2025_6edfba17.jpg";
String url4= "https://ik.imagekit.io/tvlk/blog/2023/06/chua-thien-mu-1.jpg?tr=dpr-2,w-675";
String url5= "https://upload.wikimedia.org/wikipedia/commons/0/0e/Hue%2C_le_pont_Trang_Tien.jpg";
String url6= "https://blog.vinastay.com/wp-content/uploads/2018/10/vinpearl-hue-o-dau-3.jpg";
//Mock data

var listClasroom = [
  Classroom("2024-2025.1.TIN2022.001","2024-2025.1","Lập trình di động nhóm 01", 40,bgUrl: url1),
  Classroom("2024-2025.1.TIN2022.002","2024-2025.1","Lập trình di động nhóm 02", 50,bgUrl: url2),
  Classroom("2024-2025.1.TIN2022.003","2024-2025.1","Lập trình di động nhóm 03", 60,bgUrl: url3),
  Classroom("2024-2025.1.TIN2022.004","2024-2025.1","Lập trình di động nhóm 04", 45,bgUrl: url4 ),
  Classroom("2024-2025.1.TIN2022.005","2024-2025.1","Lập trình di động nhóm 05", 55,bgUrl: url5),
  Classroom("2024-2025.1.TIN2022.006","2024-2025.1","Lập trình di động nhóm 06", 65,bgUrl: url6),
];