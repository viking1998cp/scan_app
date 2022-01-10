part of 'home_screen.dart';

extension HomeScreenChildren on HomeScreen {
  PreferredSize _appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(216.0), // here the desired height
        child: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.SETTING);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 16, top: 15),
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            )
          ],
          flexibleSpace: Container(
            child: Image.asset("assets/images/image_home.png"),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red,
                    Theme.of(context).primaryColor,
                    Colors.white,
                  ],
                )),
          ),
        ));
  }

  Widget _itemMenu(
      {required String title,
      required String icon,
      required String detail,
      required Function() onclick}) {
    return TextButton(
      onPressed: () {
        onclick();
      },
      style: ButtonAppStyle().buttonWrap(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 5,
              offset: Offset(1, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                icon,
                width: 24,
                height: 24,
                color: Colors.red,
              ),
              // Icon(
              //   icon,
              //   color: Colors.red,
              //   size: 24,
              // ),
              Text(title, style: TextAppStyle().textTitleStyle()),
              SizedBox(
                height: 8,
              ),
              Text(
                detail,
                style: TextAppStyle().textMediumStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
