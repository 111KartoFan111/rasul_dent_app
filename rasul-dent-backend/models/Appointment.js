const mongoose = require('mongoose');

// Определяем схему (структуру) для документа "Запись на прием" в MongoDB
const appointmentSchema = new mongoose.Schema({
  patientName: {
    type: String,
    required: true, // Поле обязательное
  },
  doctorName: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    required: true,
  },
  service: {
    type: String, // Название услуги, например "Чистка" или "Лечение кариеса"
    required: true,
  },
  clinicId: {
    type: String, // Может быть ID из Google Places или ваш внутренний ID
    required: false, // Поле необязательное
  },
  createdAt: {
    type: Date,
    default: Date.now, // Автоматически ставить дату создания
  },
});

// Экспортируем модель. 'Appointment' - это название модели, 
// Mongoose автоматически создаст коллекцию 'appointments' (во мн. числе)
module.exports = mongoose.model('Appointment', appointmentSchema);

