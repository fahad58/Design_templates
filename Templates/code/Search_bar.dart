class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 14, 24, 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          
          color: Theme.of(context).colorScheme.background,
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                2,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                child: InkWell(
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
                          // onTap: () {
                          //   FocusScope.of(context).unfocus();
                          //   FocusManager.instance.primaryFocus?.unfocus();
                          // },
                          // child: Padding(
                          //   padding: MediaQuery.of(context).viewInsets,
                          //   child: StayModalWidget(),
                          // ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0),
                  child: InkWell(
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
                            // onTap: () {
                            //   FocusScope.of(context).unfocus();
                            //   FocusManager.instance.primaryFocus?.unfocus();
                            // },
                            // child: Padding(
                            //   padding: MediaQuery.of(context).viewInsets,
                            //   child: StayModalWidget(),
                            // ),
                          );
                        },
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0),
                                child: Text(
                                  'Where to ?',
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontFamily: 'SFPRO',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0),
                                  child: Text(
                                    'Any Where . Any week . Add guestes',
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontFamily: 'SFPRO',
                                          color: Theme.of(context).textTheme.bodySmall?.color,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey,
                    width: 1,
                  ),
                ),
                child: InkWell(
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
                          // onTap: () {
                          //   FocusScope.of(context).unfocus();
                          //   FocusManager.instance.primaryFocus?.unfocus();
                          // },
                          // child: Padding(
                          //   padding: MediaQuery.of(context).viewInsets,
                          //   child: FiltersModalWidget(),
                          // ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.tune,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
