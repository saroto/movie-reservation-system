import { Test, TestingModule } from '@nestjs/testing';
import { ReservationSeatController } from './reservation-seat.controller';
import { ReservationSeatService } from './reservation-seat.service';

describe('ReservationSeatController', () => {
  let controller: ReservationSeatController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ReservationSeatController],
      providers: [ReservationSeatService],
    }).compile();

    controller = module.get<ReservationSeatController>(ReservationSeatController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
