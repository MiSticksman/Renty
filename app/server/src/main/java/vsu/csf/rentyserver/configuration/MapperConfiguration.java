package vsu.csf.rentyserver.configuration;

import org.mapstruct.MapperConfig;
import org.mapstruct.NullValueMappingStrategy;

@MapperConfig(
        componentModel = "spring",
        nullValueMappingStrategy = NullValueMappingStrategy.RETURN_DEFAULT,
        nullValueIterableMappingStrategy = NullValueMappingStrategy.RETURN_DEFAULT
)
public class MapperConfiguration {
}
