import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/netflix_logo.dart';

/// Halaman Register Netflix Clone.
///
/// Fitur:
/// - Desain sinematik premium konsisten dengan Login Page.
/// - Input Full Name, Email, Password, Confirm Password.
/// - Tombol Create Account: menampilkan notifikasi simulasi pendaftaran UI,
///   kemudian mengarahkan pengguna kembali ke Login Page.
/// - Link "Already have an account? Sign In" menuju Login Page.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _buttonHovered = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onCreateAccountPressed() {
    // Tampilkan notifikasi bahwa pendaftaran hanya simulasi UI, lalu arahkan ke Login Page
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF1B4332),
          duration: Duration(seconds: 3),
          content: Row(
            children: <Widget>[
              Icon(
                Icons.check_circle_rounded,
                color: AppTheme.matchGreen,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Simulasi pendaftaran berhasil! Silakan masuk melalui halaman Sign In.',
                  style: TextStyle(color: AppTheme.primaryText),
                ),
              ),
            ],
          ),
        ),
      );

    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 1. Full-screen Cinematic Backdrop
          Image.network(
            MovieData.authBackgroundUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.4,
                  colors: <Color>[
                    Color(0xFF450A0A),
                    AppTheme.primaryBackground,
                  ],
                ),
              ),
            ),
          ),

          // 2. Dark Overlay & Transparent Black Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: <double>[0.0, 0.45, 1.0],
                colors: <Color>[
                  Color(0xE0000000),
                  Color(0xA6000000),
                  Color(0xEB000000),
                ],
              ),
            ),
          ),

          // 3. Scrollable Content: Header + Register Card + Footer
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenSize.height -
                      MediaQuery.of(context).padding.vertical,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Header with Netflix Logo & Sign In Shortcut
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 56,
                        vertical: isMobile ? 20 : 28,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          NetflixLogo(
                            fontSize: isMobile ? 28 : 40,
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppTheme.netflixRed,
                              foregroundColor: AppTheme.primaryText,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Centered Register Form Card
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Container(
                        width: isMobile ? double.infinity : 480,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24 : 56,
                          vertical: isMobile ? 32 : 46,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.80),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.borderColor.withValues(alpha: 0.5),
                          ),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color(0xAA000000),
                              blurRadius: 32,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                color: AppTheme.primaryText,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Unlimited movies, TV shows, and more.',
                              style: TextStyle(
                                color: AppTheme.secondaryText,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // 1. Full Name
                            CustomTextField(
                              controller: _fullNameController,
                              label: 'Full Name',
                              hintText: 'Enter your full name',
                              prefixIcon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 14),

                            // 2. Email Address
                            CustomTextField(
                              controller: _emailController,
                              label: 'Email Address',
                              hintText: 'name@example.com',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email_outlined,
                            ),
                            const SizedBox(height: 14),

                            // 3. Password
                            CustomTextField(
                              controller: _passwordController,
                              label: 'Password',
                              isPassword: true,
                              prefixIcon: Icons.lock_outline_rounded,
                            ),
                            const SizedBox(height: 14),

                            // 4. Confirm Password
                            CustomTextField(
                              controller: _confirmPasswordController,
                              label: 'Confirm Password',
                              isPassword: true,
                              prefixIcon: Icons.verified_user_outlined,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) =>
                                  _onCreateAccountPressed(),
                            ),
                            const SizedBox(height: 24),

                            // Create Account Button
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) =>
                                  setState(() => _buttonHovered = true),
                              onExit: (_) =>
                                  setState(() => _buttonHovered = false),
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _onCreateAccountPressed,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _buttonHovered
                                        ? AppTheme.hoverRed
                                        : AppTheme.netflixRed,
                                    foregroundColor: AppTheme.primaryText,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Link "Already have an account? Sign In"
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    color: AppTheme.secondaryText,
                                    fontSize: 14.5,
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/login');
                                    },
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: AppTheme.primaryText,
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Simple Dark Footer
                    Container(
                      width: double.infinity,
                      color: Colors.black.withValues(alpha: 0.78),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 80,
                        vertical: 20,
                      ),
                      child: const Text(
                        'Netflix Clone — Educational Project (Flutter Web & Dart)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.secondaryText,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
