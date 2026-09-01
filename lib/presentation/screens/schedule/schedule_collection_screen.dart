import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/presentation/controllers/schedule_controller.dart';
import 'package:lactarehub/presentation/screens/schedule/components/schedule_pickers.dart';
import 'package:lactarehub/presentation/shared/components/app_feedback.dart';
import 'package:lactarehub/presentation/shared/components/app_text_field.dart';
import 'package:lactarehub/presentation/shared/components/app_top_bar.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';
import 'package:lactarehub/presentation/shared/components/section_title.dart';

/// Aba "Doar" — formulário de agendamento de uma nova coleta.
///
/// Complementa as telas do protótipo, dando destino aos botões
/// "Nova coleta" e "Agendar nova coleta".
class ScheduleCollectionScreen extends StatefulWidget {
  const ScheduleCollectionScreen({super.key, required this.onScheduled});

  final VoidCallback onScheduled;

  @override
  State<ScheduleCollectionScreen> createState() =>
      _ScheduleCollectionScreenState();
}

class _ScheduleCollectionScreenState extends State<ScheduleCollectionScreen> {
  final ScheduleController _controller = ScheduleController();
  final TextEditingController _notesField = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    _notesField.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    _controller.updateNotes(_notesField.text.trim());
    final schedule = await _controller.submit();
    if (!mounted || schedule == null) return;

    AppFeedback.success(
      context,
      'Coleta agendada para '
      '${Formatters.weekdayAndDate(schedule.scheduledAt)}, '
      '${schedule.timeWindow}.',
    );
    widget.onScheduled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            if (_controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                const AppTopBar(title: 'Agendar coleta'),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.page,
                      AppSpacing.xl,
                      AppSpacing.page,
                      AppSpacing.xl,
                    ),
                    children: [
                      Text(
                        'Vamos combinar a sua próxima doação',
                        style: AppTextStyles.heroTitle.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Escolha como quer entregar o leite, o dia e a janela '
                        'de horário que cabem na sua rotina.',
                        style: AppTextStyles.body,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      const SectionTitle(title: 'Como você prefere doar?'),
                      const SizedBox(height: AppSpacing.lg),
                      ModeSelector(
                        selected: _controller.mode,
                        onSelected: _controller.selectMode,
                      ),
                      if (_controller.requiresPoint) ...[
                        const SizedBox(height: AppSpacing.lg),
                        _PointPicker(
                          points: _controller.points,
                          selected: _controller.selectedPoint,
                          onSelected: _controller.selectPoint,
                        ),
                      ],
                      const SizedBox(height: AppSpacing.xxl),
                      const SectionTitle(title: 'Escolha o dia'),
                      const SizedBox(height: AppSpacing.lg),
                      DateStrip(
                        dates: _controller.selectableDates,
                        selected: _controller.date,
                        onSelected: _controller.selectDate,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      const SectionTitle(title: 'Janela de horário'),
                      const SizedBox(height: AppSpacing.lg),
                      TimeWindowGrid(
                        windows: _controller.availableWindows,
                        selected: _controller.timeWindow,
                        onSelected: _controller.selectTimeWindow,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      AppTextField(
                        label: 'Observações (opcional)',
                        hint: 'Ex.: interfone com defeito, chamar no celular',
                        controller: _notesField,
                        maxLines: 3,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      PrimaryButton(
                        label: 'Confirmar agendamento',
                        icon: Icons.event_available_outlined,
                        showTrailingIcon: false,
                        isLoading: _controller.isSubmitting,
                        onPressed: _controller.canSubmit ? _submit : null,
                      ),
                      if (!_controller.canSubmit) ...[
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Selecione dia e horário'
                          '${_controller.requiresPoint ? ' e um ponto de coleta' : ''}'
                          ' para continuar.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Lista suspensa dos pontos da rede, exibida quando a entrega é presencial.
class _PointPicker extends StatelessWidget {
  const _PointPicker({
    required this.points,
    required this.selected,
    required this.onSelected,
  });

  final List<CollectionPoint> points;
  final CollectionPoint? selected;
  final ValueChanged<CollectionPoint> onSelected;

  @override
  Widget build(BuildContext context) {
    final selectable = points
        .where((point) => point.type != CollectionPointType.coletaDomiciliar)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ponto de entrega', style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.inputBR,
            border: Border.all(color: AppColors.borderInput),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CollectionPoint>(
              value: selected,
              isExpanded: true,
              hint: Text('Selecione um ponto', style: AppTextStyles.bodySmall),
              icon: const Icon(
                Icons.expand_more,
                color: AppColors.navInactive,
              ),
              borderRadius: AppRadius.inputBR,
              items: [
                for (final point in selectable)
                  DropdownMenuItem<CollectionPoint>(
                    value: point,
                    child: Text(
                      point.name,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.ink,
                      ),
                    ),
                  ),
              ],
              onChanged: (point) {
                if (point != null) onSelected(point);
              },
            ),
          ),
        ),
      ],
    );
  }
}
