class AccountSettingsWidget extends StatelessWidget {
  const AccountSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  'Account setting',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'SFPRO',
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ],
          ),

          /// Personal Information
          ProfileSettingItemsWidget(
            icon: const Icon(FFIcons.kuserCircle),
            title: 'Personal information',
            activeDivider: false,
            onPressed: () {
              // TODO: Handle personal information tap
            },
          ),

          /// Payment Methods
          ProfileSettingItemsWidget(
            icon: const Icon(FFIcons.kcreditCard),
            title: 'Payment methods',
            activeDivider: false,
            onPressed: () {
              // TODO: Handle payment methods tap
            },
          ),

          /// Taxes - Modal Bottom Sheet
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                enableDrag: false,
                context: context,
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: TaxesModalWidget(),
                    ),
                  );
                },
              );
            },
            child: ProfileSettingItemsWidget(
              icon: const Icon(FFIcons.kfile),
              title: 'Taxes',
            ),
          ),

          /// Login & Security
          ProfileSettingItemsWidget(
            icon: const Icon(FFIcons.kshield),
            title: 'Login & security',
            activeDivider: false,
            onPressed: () {
              // TODO: Handle login & security tap
            },
          ),

          /// Translation
          ProfileSettingItemsWidget(
            icon: const Icon(Icons.translate),
            title: 'Translation',
            activeDivider: false,
            onPressed: () {
              // TODO: Handle translation tap
            },
          ),

          /// Notifications
          ProfileSettingItemsWidget(
            icon: const Icon(FFIcons.kbell),
            title: 'Notifications',
            activeDivider: false,
            onPressed: () {
              // TODO: Handle notifications tap
            },
          ),

          /// Privacy and Sharing
          ProfileSettingItemsWidget(
            icon: const Icon(FFIcons.klock),
            title: 'Privacy and sharing',
            activeDivider: false,
            onPressed: () {
              // TODO: Handle privacy and sharing tap
            },
          ),
        ].divide(const SizedBox(height: 8)),
      ),
    );
  }
}
