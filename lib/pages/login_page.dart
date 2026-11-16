import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/netflix_logo.dart';

/// Halaman Login Netflix Clone.
///
/// Fitur:
/// - Desain sinematik premium dengan dark overlay dan logo Netflix.
/// - Input Email dan Password sebagai elemen visual interaktif.
/// - Checkbox Remember Me dan link Need Help.
/// - Tombol Sign In: langsung mengarahkan pengguna ke Netflix Dashboard (/home)
///   tanpa verifikasi autentikasi/database/demo account.
/// - Link "Sign up now" menuju Register Page.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _buttonHovered = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInPressed() {
    // Navigasi langsung ke Netflix Dashboard tanpa autentikasi/database
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _showNeedHelpDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.secondaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppTheme.borderColor),
          ),
          title: const Row(
            children: <Widget>[
              Icon(Icons.help_outline_rounded, color: AppTheme.netflixRed),
              SizedBox(width: 10),
              Text(
                'Need Help?',
                style: TextStyle(
                  color: AppTheme.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: const Text(
            'Halaman ini merupakan replika antarmuka Netflix untuk tugas kuliah.\n\n'
            'Anda dapat langsung menekan tombol "Sign In" untuk masuk ke Netflix Dashboard.',
            style: TextStyle(
              color: AppTheme.secondaryText,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.netflixRed,
                foregroundColor: AppTheme.primaryText,
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
          // 1. Full-screen Cinematic Movie Backdrop Image
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

          // 2. Dark Overlay + Transparent Black Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: <double>[0.0, 0.45, 1.0],
                colors: <Color>[
                  Color(0xDF000000),
                  Color(0x9E000000),
                  Color(0xEB000000),
                ],
              ),
            ),
          ),

          // 3. Scrollable Foreground: Header + Centered Login Card + Footer
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
                    // Top-Left Netflix Logo Header
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 56,
                        vertical: isMobile ? 20 : 28,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NetflixLogo(fontSize: isMobile ? 28 : 40),
                      ),
                    ),

                    // Centered Dark Translucent Login Form Card
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Container(
                        width: isMobile ? double.infinity : 450,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24 : 64,
                          vertical: isMobile ? 36 : 52,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.78),
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
                              'Sign In',
                              style: TextStyle(
                                color: AppTheme.primaryText,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 26),

                            // Email or Phone Number Input (Visual element)
                            CustomTextField(
                              controller: _emailController,
                              label: 'Email or phone number',
                              hintText: 'name@example.com',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email_outlined,
                            ),
                            const SizedBox(height: 16),

                            // Password Input with Show/Hide Toggle (Visual element)
                            CustomTextField(
                              controller: _passwordController,
                              label: 'Password',
                              isPassword: true,
                              prefixIcon: Icons.lock_outline_rounded,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _onSignInPressed(),
                            ),
                            const SizedBox(height: 24),

                            // Red Sign In Button (Navigates directly to Dashboard)
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) =>
                                  setState(() => _buttonHovered = true),
                              onExit: (_) =>
                                  setState(() => _buttonHovered = false),
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _onSignInPressed,
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
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Remember Me Checkbox & Need Help Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _rememberMe = !_rememberMe;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Checkbox(
                                          value: _rememberMe,
                                          activeColor: AppTheme.netflixRed,
                                          checkColor: AppTheme.primaryText,
                                          side: const BorderSide(
                                            color: AppTheme.secondaryText,
                                          ),
                                          onChanged: (bool? val) {
                                            setState(() {
                                              _rememberMe = val ?? true;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Remember me',
                                        style: TextStyle(
                                          color: AppTheme.secondaryText,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: _showNeedHelpDialog,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 26),
                                  ),
                                  child: const Text(
                                    'Need help?',
                                    style: TextStyle(
                                      color: AppTheme.secondaryText,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),

                            // "New to Netflix? Sign up now."
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'New to Netflix? ',
                                  style: TextStyle(
                                    color: AppTheme.secondaryText,
                                    fontSize: 15,
                                  ),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/register');
                                    },
                                    child: const Text(
                                      'Sign up now.',
                                      style: TextStyle(
                                        color: AppTheme.primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'This page is part of the Netflix Clone college project.',
                              style: TextStyle(
                                color: AppTheme.secondaryText
                                    .withValues(alpha: 0.65),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Netflix Dark Footer
                    Container(
                      width: double.infinity,
                      color: Colors.black.withValues(alpha: 0.78),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 80,
                        vertical: 24,
                      ),
                      child: Wrap(
                        spacing: 28,
                        runSpacing: 12,
                        alignment: WrapAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Netflix Clone College Project — Flutter Web & Dart',
                            style: TextStyle(
                              color: AppTheme.secondaryText,
                              fontSize: 13,
                            ),
                          ),
                          Wrap(
                            spacing: 20,
                            runSpacing: 8,
                            children: const <Widget>[
                              Text(
                                'FAQ',
                                style: TextStyle(
                                  color: AppTheme.secondaryText,
                                  fontSize: 12.5,
                                ),
                              ),
                              Text(
                                'Help Center',
                                style: TextStyle(
                                  color: AppTheme.secondaryText,
                                  fontSize: 12.5,
                                ),
                              ),
                              Text(
                                'Terms of Use',
                                style: TextStyle(
                                  color: AppTheme.secondaryText,
                                  fontSize: 12.5,
                                ),
                              ),
                              Text(
                                'Privacy',
                                style: TextStyle(
                                  color: AppTheme.secondaryText,
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                        ],
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
