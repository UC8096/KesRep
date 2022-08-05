part of 'pages.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orangeRedCrayola,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_cellular_connected_no_internet_4_bar_outlined,
              color: eerieBlack,
              size: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300,
              child: Text(
                "Tidak Ada Koneksi Internet",
                textAlign: TextAlign.center,
                style: interheadline1.copyWith(color: white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: Text(
                "Coba pastikan lagi koneksi internet kamu dan tekan tomobol coba lagi di bawah. Jika kamu mengalami kesulitan mintalah bantuan orang disekitarmu !",
                textAlign: TextAlign.center,
                style: interheadline4.copyWith(color: white),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            bigButtonWidget(
              text: "Coba Lagi",
              width: 200,
              primaryColor: white,
              secondaryColor: silver,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/loadingpage',
                  (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
