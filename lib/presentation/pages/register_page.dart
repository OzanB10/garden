import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../../config/providers/auth_providers.dart';
import 'home_page.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.textPrimary,
            size: AppDimensions.iconMedium,
          ),
        ),
      ),
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
                const SizedBox(height: AppDimensions.spacing16),
                _buildHeader(),
                const SizedBox(height: AppDimensions.spacing32),
                _buildRegisterForm(),
                const SizedBox(height: AppDimensions.spacing32),
                _buildRegisterButton(),
                const SizedBox(height: AppDimensions.spacing24),
                _buildDivider(),
                const SizedBox(height: AppDimensions.spacing24),
                _buildSignInRow(),
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
          AppStrings.registerTitle,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontHeader,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing8),
        Text(
          AppStrings.registerSubtitle,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontLarge,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: AppStrings.nameHint,
            controller: _nameController,
            validator: Validators.validateName,
            keyboardType: TextInputType.name,
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: AppDimensions.spacing16),
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
          const SizedBox(height: AppDimensions.spacing16),
          CustomTextField(
            hintText: AppStrings.confirmPasswordHint,
            controller: _confirmPasswordController,
            validator: (value) => Validators.validateConfirmPassword(
              value,
              _passwordController.text,
            ),
            isPassword: true,
            prefixIcon: Icons.lock_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    final authState = ref.watch(authControllerProvider);
    
    return CustomButton(
      text: AppStrings.registerButton,
      onPressed: _handleRegister,
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

  Widget _buildSignInRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.hasAccount,
          style: GoogleFonts.poppins(
            fontSize: AppDimensions.fontMedium,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            AppStrings.loginButton,
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

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      ref.read(authControllerProvider.notifier).register(
        name: name,
        email: email,
        password: password,
      );
    }
  }
} 