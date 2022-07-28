part of 'questions.dart';

Widget textTextQuestion({
  Quiz? quiz,
  InGameViewModel? viewModel,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 100,
            height: 100,
            color: silver,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 35,
            ),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: lightMint,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        quiz?.pertanyaan ??
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum pharetra non odio quis auctor.',
                        style: interheadline7.copyWith(
                          color: spanishGray,
                        ),
                      ),
                    ),
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
                            viewModel!.playSound!(quiz!.sound!);
                          },
                          icon: Icon(
                            Icons.volume_up_rounded,
                            color: davysGrey,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Wrap(
          spacing: 25,
          runSpacing: 25,
          children: quiz!.pilihan!
              .map(
                (e) => bigButtonWidget(
                  text: e.data,
                  onTap: () {
                    viewModel?.addQuizAnswered!(
                      quiz,
                      e,
                    );
                  },
                  primaryColor: viewModel!.isQuizAnswered!(quiz.id!, e.data!)
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
