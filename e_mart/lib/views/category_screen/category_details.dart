import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/category_screen/item_details.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6,
                          (index)=> "Baby Clothing".text.size(12).fontFamily(semibold).color(darkFontGrey).makeCentered()
                              .box.roundedSM.white.size(120, 60).margin(EdgeInsets.symmetric(horizontal: 4)).make()),
                ),
              ),
              20.heightBox,
              //items container
              Expanded(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 8, mainAxisExtent: 250),
                      itemBuilder: (context, index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(imgP5, width: 200, height: 150, fit: BoxFit.cover,),
                            "Laptop 4GB/256GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                            5.heightBox,
                            "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
                          ],
                        ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.outerShadowSm.padding(EdgeInsets.all(12)).make()
                            .onTap((){Get.to(ItemDetails(title: "Dummy Item"));});
                      })),
            ],
          ),
        ),
      ),
    ) ;
  }
}
