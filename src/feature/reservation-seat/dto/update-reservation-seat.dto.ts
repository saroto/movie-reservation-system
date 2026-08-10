import { PartialType } from '@nestjs/mapped-types';
import { CreateReservationSeatDto } from './create-reservation-seat.dto';

export class UpdateReservationSeatDto extends PartialType(CreateReservationSeatDto) {}
