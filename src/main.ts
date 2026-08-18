import { NestFactory } from '@nestjs/core';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';
import { VersioningType } from '@nestjs/common';
import { AppConfigService } from './core/config/config.service';
import { swaggerBasicAuth } from './common/guard/swagger-basis.guard';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const configService = app.get(AppConfigService);
  const swaggerEnabled = configService.getSwaggerEnabled();
  const swaggerEndpoint = configService.getSwaggerEndpoint();
  const swaggerUiEndpoint = configService.getSwaggerUiEndpoint();

  app.setGlobalPrefix(configService.getApiPrefix());

  app.enableVersioning({
    type: VersioningType.URI,
    defaultVersion: '1',
    prefix: 'v',
  });
  if (swaggerEnabled) {
    const swaggerConfig = new DocumentBuilder()
      .setTitle('Movie Reservation System API')
      .setDescription('API documentation for the Movie Reservation System')
      .setVersion('1.0')
      .build();
    const document = SwaggerModule.createDocument(app, swaggerConfig);
    // app.use(
    //   [`${swaggerUiEndpoint}`, `${swaggerEndpoint}`],
    //   swaggerBasicAuth(configService.swaggerUsername, configService.swaggerPassword),
    // )
    SwaggerModule.setup(swaggerUiEndpoint, app, document, {
      jsonDocumentUrl: swaggerEndpoint,
    });
  }
  await app.listen(3000);
}
bootstrap();
