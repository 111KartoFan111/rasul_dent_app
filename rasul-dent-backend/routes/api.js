const express = require('express');
const router = express.Router();
const Appointment = require('../models/Appointment');

// Динамический импорт node-fetch
// Мы используем import() в commonjs, так как node-fetch v3+ является ESM
let fetch;
import('node-fetch').then(module => {
  fetch = module.default;
});

// --- Маршруты Google Places API ---
// Ищет стоматологические клиники рядом
router.get('/places/dental-clinics', async (req, res) => {
  const { lat, lon } = req.query; // Ожидаем широту (lat) и долготу (lon)
  const GOOGLE_PLACES_API_KEY = process.env.GOOGLE_PLACES_API_KEY;

  if (!lat || !lon) {
    return res.status(400).json({ error: 'Необходимо указать широту (lat) и долготу (lon).' });
  }

  if (!fetch) {
    return res.status(500).json({ error: 'Сервис fetch еще не загружен.' });
  }

  // URL для поиска "dental clinic" в радиусе 5000 метров
  const url = `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat},${lon}&radius=5000&type=dental_clinic&key=${GOOGLE_PLACES_API_KEY}`;

  try {
    const response = await fetch(url);
    const data = await response.json();
    res.json(data);
  } catch (error) {
    console.error('Ошибка при запросе к Google Places API:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});

// --- Маршруты Gemini API ---
// Отправляет промпт (запрос) к Gemini
router.post('/gemini/ask', async (req, res) => {
  const { prompt } = req.body;
  const GEMINI_API_KEY = process.env.GEMINI_API_KEY;

  if (!prompt) {
    return res.status(400).json({ error: 'Необходимо передать "prompt".' });
  }

  if (!fetch) {
    return res.status(500).json({ error: 'Сервис fetch еще не загружен.' });
  }

  // Используем gemini-2.5-flash-preview-09-2025 - быстрая и эффективная модель
  const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent?key=${GEMINI_API_KEY}`;

  const payload = {
    contents: [{ parts: [{ text: prompt }] }],
    // systemInstruction: {
    //   parts: [{ text: "Ты — полезный ассистент для стоматологического приложения." }]
    // },
  };

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });

    if (!response.ok) {
        const errorData = await response.json();
        console.error('Ошибка от Gemini API:', errorData);
        return res.status(response.status).json({ error: 'Ошибка от Gemini API', details: errorData });
    }

    const data = await response.json();
    
    // Извлекаем текст ответа
    const text = data.candidates?.[0]?.content?.parts?.[0]?.text;
    res.json({ response: text || "Не удалось получить ответ от Gemini." });

  } catch (error) {
    console.error('Ошибка при запросе к Gemini API:', error);
    res.status(500).json({ error: 'Внутренняя ошибка сервера' });
  }
});


// --- Маршруты для Записей (Appointments) ---

// POST - Создать новую запись
router.post('/appointments', async (req, res) => {
  try {
    // Получаем данные из тела запроса
    const { patientName, doctorName, date, service, clinicId } = req.body;
    
    // Создаем новый документ по Mongoose-модели
    const newAppointment = new Appointment({
      patientName,
      doctorName,
      date,
      service,
      clinicId
    });
    
    // Сохраняем в базу данных
    const savedAppointment = await newAppointment.save();
    // Отправляем успешный ответ
    res.status(201).json(savedAppointment);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// GET - Получить все записи
router.get('/appointments', async (req, res) => {
  try {
    const appointments = await Appointment.find();
    res.json(appointments);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// GET - Получить одну запись по ID
router.get('/appointments/:id', async (req, res) => {
  try {
    const appointment = await Appointment.findById(req.params.id);
    if (appointment == null) {
      return res.status(404).json({ message: 'Запись не найдена' });
    }
    res.json(appointment);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Не забываем экспортировать router, чтобы `server.js` мог его использовать
module.exports = router;

