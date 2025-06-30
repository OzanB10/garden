import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'register_page.dart';
import 'home_page.dart';
import '../../config/providers/auth_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listen(authControllerProvider, (previous, next) {
        if (next.isAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (next.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
              backgroundColor: AppColors.alertIcon,
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingHorizontal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimensions.spacing32),
                _buildHeader(),
                const SizedBox(height: AppDimensions.spacing32),
                _buildLoginForm(),
                const SizedBox(height: AppDimensions.spacing24),
                _buildForgotPasswordButton(),
                const SizedBox(height: AppDimensions.spacing32),
                _buildLoginButton(),
                const SizedBox(height: AppDimensions.spacing24),
                _buildDivider(),
                const SizedBox(height: AppDimensions.spacing24),
                _buildSignUpRow(),
                const SizedBox(height: AppDimensions.spacing32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.loginTitle,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontHeader,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing8),
        Text(
          AppStrings.loginSubtitle,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontLarge,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: AppStrings.emailHint,
            controller: _emailController,
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
          ),
          const SizedBox(height: AppDimensions.spacing16),
          CustomTextField(
            hintText: AppStrings.passwordHint,
            controller: _passwordController,
            validator: Validators.validatePassword,
            isPassword: true,
            prefixIcon: Icons.lock_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password
        },
        child: Text(
          AppStrings.forgotPassword,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontMedium,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    final authState = ref.watch(authControllerProvider);
    
    return CustomButton(
      text: AppStrings.loginButton,
      onPressed: _handleLogin,
      isLoading: authState.isLoading,
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.taskBorder,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing16,
          ),
          child: Text(
            AppStrings.orDivider,
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontMedium,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.taskBorder,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.noAccount,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontMedium,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );
          },
          child: Text(
            AppStrings.registerButton,
            style: GoogleFonts.poppins(
              fontSize: AppDimensions.fontMedium,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      ref.read(authControllerProvider.notifier).login(
        email: email,
        password: password,
      );
    }
  }
} 