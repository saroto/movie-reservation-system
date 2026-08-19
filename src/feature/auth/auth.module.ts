import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { AuthRepository } from './auth.repository';
import { TokenModule } from 'src/core/token/token.module';
import { PrismaModule } from 'src/core/database/prisma.module';
import { AppConfigModule } from 'src/core/config/config.module';
import { UserModule } from '../user/user.module';

@Module({
  controllers: [AuthController],
  providers: [AuthService, AuthRepository],
  imports: [AppConfigModule, TokenModule, PrismaModule, UserModule],
})
export class AuthModule { }
