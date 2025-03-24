class OnboardingModel {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

// Sample onboarding data
List<OnboardingModel> onboardingData = [
  OnboardingModel(
    title: "Welcome to Global Pen Reads",
    description: "Discover a world of books at your fingertips. Read, listen, and enjoy stories that inspire, educate, and entertain.",
    imageUrl: "https://cdni.iconscout.com/illustration/premium/thumb/welcome-banner-decoration-illustration-download-in-svg-png-gif-file-formats--balloons-decorative-pack-miscellaneous-illustrations-3231445.png?f=webp",
  ),
  OnboardingModel(
    title: "Listen to Your Favorite Books",
    description: "Immerse yourself in captivating audiobooks anytime, anywhere. Let the stories come to life with just a tap.",
    imageUrl: "https://cdni.iconscout.com/illustration/premium/thumb/audio-book-illustration-download-in-svg-png-gif-file-formats--e-learning-audiobook-education-pack-school-illustrations-6073426.png?f=webp",
  ),
  OnboardingModel(
    title: "Easy to Explore",
    description: "Find books effortlessly with our seamless navigation. Browse by genre, author, or trending titles and start reading instantly.",
    imageUrl: "https://media.istockphoto.com/id/1304020328/vector/happy-woman-holding-huge-tourists-binocular.jpg?s=612x612&w=0&k=20&c=095ojLDyYGQTDKXaCK24Yhk3I3LXdV8hPwlggSsTyGY=",
  ),
];
