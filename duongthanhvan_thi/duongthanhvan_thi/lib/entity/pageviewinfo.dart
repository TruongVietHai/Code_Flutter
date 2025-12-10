
class PageViewInfo {
  late String avtUrl;
  late String title;
  late String content;

  PageViewInfo({required this.title, required this.content, this.avtUrl = ""});
}

List<PageViewInfo> listPageViewMeeting = [
  PageViewInfo(
    title: "Cuộc họp 1",
    content: "Vịnh Hạ Long",
    avtUrl: "https://media.baoquangninh.vn/dataimages/201809/original/images1098138_vinh_ha_long.jpg",
  ),
  PageViewInfo(
    title: "Cuộc họp 2",
    content: "Trường Tiền - chuyện chưa kể cây cầu lịch sử - Kỳ 3: Chiếc cầu truân chuyên",
    avtUrl: "https://cdn.tuoitre.vn/thumb_w/1200/2021/8/5/bai-3-cau-tt-5-2read-only-16281696465111496571743.jpg",
  ),
  PageViewInfo(
    title: "Cuộc họp 3",
    content: "Đánh giá xe BMW X5 2019 thế hệ mới",
    avtUrl: "https://img1.oto.com.vn/crop/640x360/2018/06/07/4FXoELMG/danh-gia-xe-bmw-x5-2-c8f1_wm.jpg",
  ),
];

