part of 'questions.dart';

Widget imageTextQuestion({
  required context,
  Quiz? quiz,
  InGameViewModel? viewModel,
  String? character,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: lightMint,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 5,
                          right: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            viewModel!.openImage!(quiz!.gambar!);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                                quiz!.gambar ?? 'assets/materi/risiko.png',
                                errorBuilder: (context, exception, stackTrace) {
                              return SizedBox(
                                width: 180,
                                height: 120,
                                child: Center(
                                  child: Text(
                                    "Image Error",
                                    style: interheadline3.copyWith(
                                        color: davysGrey),
                                  ),
                                ),
                              );
                            }, width: 180, height: 120, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Text(
                          quiz.pertanyaan ??
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum pharetra non odio quis auctor.',
                          style: interheadline7.copyWith(
                            color: spanishGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                  (viewModel?.isPlayingSound == true)
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 10, right: 10),
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()),
                        )
                      : IconButton(
                          onPressed: () {
                            ClickHelper.clickSound();

                            viewModel!.playSound!(quiz.pertanyaan!);
                          },
                          icon: Icon(
                            Icons.volume_up_rounded,
                            color: davysGrey,
                          ),
                        ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: lightCyan,
              ),
              child: RiveAnimation.asset(
                "assets/newcharacter.riv",
                artboard: character ?? "Avatar 1",
                controllers: [viewModel!.characterController!],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Wrap(
          runSpacing: 15,
          children: quiz.pilihan!
              .map(
                (e) => bigButtonWidget(
                  text: e.data,
                  onTap: () {
                    ClickHelper.clickSound();

                    viewModel.addQuizAnswered!(
                      quiz,
                      e,
                    );
                  },
                  primaryColor: viewModel.isQuizAnswered!(quiz.id!, e.data!)
                      ? naplesYellow
                      : lightCyan,
                  secondaryColor: viewModel.isQuizAnswered!(quiz.id!, e.data!)
                      ? cyberYellowLow
                      : nonPhotoBlue,
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}
