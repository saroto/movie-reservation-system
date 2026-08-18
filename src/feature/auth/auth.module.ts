import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { TokenModule } from 'src/core/token/token.module';
import { PrismaModule } from 'src/core/database/prisma.module';
import { AppConfigModule } from 'src/core/config/config.module';

@Module({
  controllers: [AuthController],
  providers: [AuthService],
  imports: [AppConfigModule, TokenModule, PrismaModule],
})
export class AuthModule { }
