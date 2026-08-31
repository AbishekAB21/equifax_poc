import 'package:equifax_poc/core/theme/app_color.dart';
import 'package:equifax_poc/features/auth/presentation/controllers/auth_controller.dart';
import 'package:equifax_poc/features/auth/presentation/controllers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user =
        (ref.watch(authControllerProvider).value ?? const AuthState()).user;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('No user logged in')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _section(
              title: 'Personal Information',
              items: [
                _item('First Name', user.firstName),
                _item('Last Name', user.lastName),
                _item('Email', user.email),
                _item('Gender', user.gender),
                _item('Date of Birth', user.dob),
                _item('Primary Phone', user.primaryPhone),
                _item('Secondary Phone', user.secondaryPhone),
              ],
            ),

            _section(
              title: 'Education & Work',
              items: [
                _item('Highest Degree', user.highestDegree),
                _item('Institution', user.institution),
                _item('Passing Year', user.passYear),
                _item('Occupation', user.occupation),
                _item('Experience', '${user.experienceYears} years'),
              ],
            ),

            _section(
              title: 'Address',
              items: [
                _item('Address', user.streetAddress),
                _item('Landmark', user.landmark),
                _item('City', user.city),
                _item('State', user.state),
                _item('Postal Code', user.zipCode),
                _item('Country', user.country),
              ],
            ),

            _section(
              title: 'Account',
              items: [_item('Login ID', user.loginId)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _section({required String title, required List<Widget> items}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 16),

          ...items,
        ],
      ),
    );
  }

  Widget _item(String label, String value) {
    if (value.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
