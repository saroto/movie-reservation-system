import { Test, TestingModule } from '@nestjs/testing';
import { ReservationSeatService } from './reservation-seat.service';

describe('ReservationSeatService', () => {
  let service: ReservationSeatService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ReservationSeatService],
    }).compile();

    service = module.get<ReservationSeatService>(ReservationSeatService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
