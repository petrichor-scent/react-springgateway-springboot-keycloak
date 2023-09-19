package org.viettelcloud.events.kafka;

import java.util.Map;

import org.apache.kafka.clients.producer.Producer;

public interface KafkaProducerFactory {

    Producer<String, String> createProducer(String clientId, String bootstrapServer,
            Map<String, Object> optionalProperties);

}
