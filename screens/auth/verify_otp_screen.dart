import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:go_router/go_router.dart';

class VerifyOtpScreen extends StatefulWidget {
  final Map<String, dynamic> registrationData;

  const VerifyOtpScreen({super.key, required this.registrationData});
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late final String _phoneNumber;
  late TextEditingController _otpController;
  late StreamController<ErrorAnimationType> _errorController;

  @override
  void initState() {
    super.initState();
    _phoneNumber = widget.registrationData['phoneNumber'] as String? ?? '';
    _otpController = TextEditingController();
    _errorController = StreamController<ErrorAnimationType>();

    if (_phoneNumber.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred. Please try again.'),
            ),
          );
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _errorController.close();
    super.dispose();
  }

  void _verifyOtp() {
    // Bypassing OTP check for UI purposes as requested.
    // Navigate to the next screen in the registration flow.
    context.go('/auth/vehicle-information');
  }

  void _resendOtp() {
    // Resend OTP logic can be implemented here.
    // For now, just show a message.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A new OTP has been sent.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: const Text('Verify Code'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.message,
                            size: 40,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Enter Verification Code',
                        style: theme.textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'We sent a 6-digit code to +251$_phoneNumber',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 48),
                      Form(
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          controller: _otpController,
                          errorAnimationController: _errorController,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 56,
                            fieldWidth: 48,
                            activeFillColor: theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,
                            inactiveFillColor: theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,
                            selectedFillColor: theme.inputDecorationTheme.fillColor ?? theme.colorScheme.surface,
                            activeColor: theme.primaryColor,
                            inactiveColor: Colors.grey.shade700,
                            selectedColor: theme.primaryColor,
                            borderWidth: 1,
                          ),
                          enableActiveFill: true,
                          onCompleted: (v) {
                            _verifyOtp();
                          },
                          onChanged: (value) {
                            setState((){});
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: _resendOtp,
                        child: const Text('Resend Code'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _otpController.text.length == 6 ? _verifyOtp : null,
                  child: const Text('Verify & Proceed'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}