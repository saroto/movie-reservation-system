import { Module } from '@nestjs/common';

import { AuthModule } from './feature/auth/auth.module';
import { UserModule } from './feature/user/user.module';
import { MovieModule } from './feature/movie/movie.module';
import { ShowtimeModule } from './feature/showtime/showtime.module';
import { CinemaModule } from './feature/cinema/cinema.module';
import { HallModule } from './feature/hall/hall.module';
import { ReservationModule } from './feature/reservation/reservation.module';
import { SeatModule } from './feature/seat/seat.module';
import { ReservationSeatModule } from './feature/reservation-seat/reservation-seat.module';

@Module({
  imports: [AuthModule, UserModule, MovieModule, ShowtimeModule, CinemaModule, HallModule, ReservationModule, SeatModule, ReservationSeatModule],
  exports: [AuthModule, UserModule, MovieModule, ShowtimeModule, CinemaModule, HallModule, ReservationModule, SeatModule, ReservationSeatModule],
})
export class AppModule { }
