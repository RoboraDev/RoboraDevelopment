import hashlib
def generate_urdf_with_hash(parts):
    urdf = '<?xml version="1.0"?>\n<robot name="robora_robot">'
    for part in parts:
        urdf += f'\n  <link name="{part}"/>'
    urdf += '\n</robot>'
    state_hash = hashlib.sha256(urdf.encode()).hexdigest()
    return urdf, state_hash

if __name__ == "__main__":
    parts = ["chassis", "arm"]
    urdf, hash = generate_urdf_with_hash(parts)
    print(f"URDF: {urdf}\nHash: {hash}")
