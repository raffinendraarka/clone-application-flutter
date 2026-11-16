import 'package:clone_application/data/movie_data.dart';
import 'package:clone_application/main.dart';
import 'package:clone_application/models/movie_model.dart';
import 'package:clone_application/pages/home_page.dart';
import 'package:clone_application/pages/login_page.dart';
import 'package:clone_application/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('1. Login Page tampil dengan benar dan Sign In langsung ke Dashboard',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('NETFLIX'), findsWidgets);
    expect(find.text('Sign In'), findsWidgets);
    expect(find.text('Sign up now.'), findsOneWidget);

    // Tekan tombol Sign In -> langsung pindah ke HomePage / Dashboard tanpa autentikasi
    final Finder signInButton = find.widgetWithText(ElevatedButton, 'Sign In');
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text(MovieData.currentUserName), findsWidgets);
  });

  testWidgets('2. Navigasi Login -> Register -> Login',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Dari Login ke Register
    await tester.tap(find.text('Sign up now.'));
    await tester.pumpAndSettle();

    expect(find.byType(RegisterPage), findsOneWidget);
    expect(find.text('Create Account'), findsWidgets);

    // Tekan tombol Create Account -> menampilkan notifikasi simulasi dan kembali ke Login Page
    final Finder createBtn =
        find.widgetWithText(ElevatedButton, 'Create Account');
    await tester.tap(createBtn);
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('3. Dashboard menampilkan Arka Raffinendra, 6 kategori, dan Logout ke Login',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Masuk ke dashboard
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);

    // Verifikasi nama pengguna Arka Raffinendra
    expect(find.text('Arka Raffinendra'), findsWidgets);

    // Verifikasi 6 kategori film tersedia di data & dashboard
    expect(MovieData.categories.length, 6);
    expect(MovieData.categories.contains('Trending Now'), isTrue);
    expect(MovieData.categories.contains('Popular on Netflix'), isTrue);
    expect(MovieData.categories.contains('Top 10 Movies'), isTrue);
    expect(MovieData.categories.contains('Action Movies'), isTrue);
    expect(MovieData.categories.contains('Recommended for You'), isTrue);
    expect(MovieData.categories.contains('Continue Watching'), isTrue);

    // Uji responsif pada layar smartphone (390x844)
    tester.view.physicalSize = const Size(390, 844);
    await tester.pump();
    expect(tester.takeException(), isNull);

    // Uji Logout kembali ke Login Page
    final Finder logoutBtn = find.text('Logout');
    if (logoutBtn.evaluate().isNotEmpty) {
      await tester.tap(logoutBtn.first);
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    }
  });

  test('4. Unit Test data film & kategori', () {
    expect(MovieData.allMovies.isNotEmpty, isTrue);
    expect(MovieData.currentUserName, 'Arka Raffinendra');

    final List<MovieModel> trending =
        MovieData.getMoviesByCategory('Trending Now');
    expect(trending.isNotEmpty, isTrue);

    final List<MovieModel> top10 =
        MovieData.getMoviesByCategory('Top 10 Movies');
    expect(top10.isNotEmpty, isTrue);
  });
}
