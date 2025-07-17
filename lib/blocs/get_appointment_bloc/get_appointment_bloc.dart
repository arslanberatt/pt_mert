import 'package:appointment_repository/appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_appointment_event.dart';
part 'get_appointment_state.dart';

class GetAppointmentBloc
    extends Bloc<GetAppointmentEvent, GetAppointmentState> {
  final AppointmentRepository _appointmentRepository;
  final CustomerRepository _customerRepository;
  GetAppointmentBloc({
    required AppointmentRepository appointmentRepository,
    required CustomerRepository customerRepository,
  }) : _customerRepository = customerRepository,
       _appointmentRepository = appointmentRepository,
       super(GetAppointmentInitial()) {
    on<GetAppointment>((event, emit) async {
      emit(GetAppointmentLoading());
      try {
        List<Customer> customer = await _customerRepository.getCustomer();
        List<Appointment> appointment = await _appointmentRepository
            .getAppointments();
        emit(GetAppointmentSuccess(customer, appointment));
      } catch (e) {
        emit(GetAppointmentFailure());
      }
    });
  }
}
