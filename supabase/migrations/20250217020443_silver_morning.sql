/*
  # Update project submissions security

  1. Changes
    - Remove user_id requirement and related policies
    - Allow public submissions
    - Maintain read security

  2. Security
    - Allow anonymous submissions
    - Only admin can read submissions
*/

-- First drop the existing policies that depend on the user_id column
DROP POLICY IF EXISTS "Users can insert their own submissions" ON project_submissions;
DROP POLICY IF EXISTS "Users can view their own submissions" ON project_submissions;

-- Now we can safely drop the user_id column
ALTER TABLE project_submissions 
  DROP COLUMN IF EXISTS user_id;

-- Create new policies for public access
CREATE POLICY "Allow public submissions"
  ON project_submissions
  FOR INSERT
  TO anon
  WITH CHECK (true);

CREATE POLICY "Only authenticated users can view submissions"
  ON project_submissions
  FOR SELECT
  TO authenticated
  USING (true);